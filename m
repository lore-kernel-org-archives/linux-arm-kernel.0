From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 1 Mar 2011 07:56:50 -0700
Subject: [PATCH 2/4] ARM:boot:device tree: Merge specific atags into the
	device tree
In-Reply-To: <alpine.LFD.2.00.1103010141140.10356@xanadu.home>
References: <20110228233153.24836.24176.stgit@riker>
	<20110228233337.24836.54594.stgit@riker>
	<alpine.LFD.2.00.1103010141140.10356@xanadu.home>
Message-ID: <AANLkTin1LBP61RNhgGxdXhVN8inw2N=6AqjYFZ1-FXMU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 11:45 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 28 Feb 2011, John Bonesio wrote:
>
>> This patch is to merge in key atags into the appended device tree. ?An appended
>> device tree is where the zImage has a dtb binary appended at the end of it. The
>> boot code looks for an appended device tree, then looks for a few key atags
>> passed in by the bootloader.
>>
>> The bootargs and memory size settings, if they exist, override existing values
>> in the appended device tree. If these values don't currently exist in the
>> appended device tree, they are added.
>>
>> Signed-off-by: John Bonesio <bones@secretlab.ca>
>
> Is this really useful?
>
> I understand this might be handy for testing purposes. ?But if your
> bootloader does ATAG only then your hardware is likely to have support
> in the kernel without device tree support just fine.
>
> IOW I don't think this would be of much value in upstream.

That's fine.  This feature was implemented to meet a client's
requirement and to experiment with manipulating the .dtb in the zimage
wrapper.  We're posting it here for completeness if anyone else wants
to play with it.  Same for the last patch that allows appending
multiple dtbs.

g.
