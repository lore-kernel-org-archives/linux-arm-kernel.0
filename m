From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 12 Feb 2013 17:33:31 +0000
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <20130212171310.GS17833@n2100.arm.linux.org.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212171310.GS17833@n2100.arm.linux.org.uk>
Message-ID: <511A7CEB.9000006@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/13 17:13, Russell King - ARM Linux wrote:
> On Fri, Feb 08, 2013 at 11:17:30PM +0000, Ben Dooks wrote:
>> I have been working on getting big-endian kernels working, mainly from
>> little-endian boot envrionments. The following patch series is what I
>> have been working on, mainly on the highbank and axp systems.
>
> What is missing from this is the justification about why we need this
> additional pain, given that all the supporting userspaces today are all
> LE based.
>
> Sure, I know that telcos have an endless love of big endian and don't
> understand anything else, but getting this working on non-telco socs
> seems to be a little odd.

Our problem is we have some code that works on a lot of big endian data
but is not easy to re-build to work on ARM little endian. The current 
solution is to change to running the system big endian.

Unfortunately we cannot just run user-space big endian as the MMU is
fetched in the same endian mode as the processor's data.

If we ignore the ATAG issue, then most of the support is currently in
the kernel to do this and there's not a lot of changes. I think
that some of the boot changes could be dealt with by a post-process
of the zImage (such as the zImage magic) which would make this
series less intrusive to the kernel.

I will send a new series in a day or so and see what people think.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
