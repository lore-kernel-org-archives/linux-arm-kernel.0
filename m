From: mspang@csclub.uwaterloo.ca (Michael Spang)
Date: Sat, 5 Mar 2011 16:32:52 -0500
Subject: [PATCH v2 2/2] ARM: Enable TS-78XX features in unknown revisions
In-Reply-To: <bbf948-iel.ln1@chipmunk.wormnet.eu>
References: <bbf948-iel.ln1@chipmunk.wormnet.eu>
Message-ID: <AANLkTimkmA9_T+SbF=5sqw0iEgMuKeJJ8=Vur9V_jng-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 5, 2011 at 5:32 AM, Alexander Clouter <alex@digriz.org.uk> wrote:
> Hi,
>
> In gmane.linux.kernel Michael Spang <mspang@csclub.uwaterloo.ca> wrote:
>>
>> When the manufacturer increases the revision number the platform
>> devices for the RTC, NAND, and RNG disappear. We should assume
>> new revisions have these devices instead of assuming they do not.
>>
> NACK
>
> This would break things for anyone running a custom FPGA bitstream (and
> they are out there) . ?The RTC and RNG are possibly the only things that
> are able to be implemented in a custom FPGA, the NAND is wholly TS
> specific..
>
> Please could you refrain submitting patches for TS-7800 without having
> a quick look at:
> ?* http://git.kernel.org/?p=linux/kernel/git/nico/orion.git
> ?* http://www.digriz.org.uk/ts78xx/kernel

Ok.

>
> The former is pretty much what you have to base all your patches on so
> you should be tracking it (which would have solved the re-inventing the
> revision update patch), whilst the latter would help tell you things
> that have already been done elsewhere.

>
> I can see the value in this particular patch, but problems with it could
> have trivially been avoided by reworking the FPGA ID code so that the
> RTC/NAND/RNG are only enabled when the *magic* is set to 0x00b480; then
> we should remove the all the 'case TS7800_REV_1..9' bits. ?I'll put this
> together and push it to Nico, reverting your efforts... :-/

That's a fine solution. I just wanted to avoid subjecting another user
to having to track down why the devices weren't showing up. I think
that efforts to make the kernel work with modified hardware should be
secondary to having the stock unit work properly.

Michael
