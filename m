From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 19 Feb 2010 16:34:22 -0500 (EST)
Subject: RFC patch set - kirkwood/sheeva - enable eSATA port
In-Reply-To: <1266612938.8172.76.camel@oklahoma>
References: <1266612938.8172.76.camel@oklahoma>
Message-ID: <alpine.LFD.2.00.1002191618310.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2010, John Holland wrote:

> Hi there,
> 
> included are two patches. The first enables Kconfig and basic board
> support for the eSATA version of the SheevaPlug found at
> http://www.newit.co.uk/store/index.php?main_page=index&cPath=3. No, I
> have no affiliation. The second enables the SATA interfaces on the SoC
> to allow eSATA visibility.
> 
> I'm opening a discussion to help us decide if the first patch is
> necessary. Please keep in mind, I also have a third non-disclosed patch
> that enables SD WP/CD on the same hardware: I have seen that the SoC MPP
> is also connected to the SD card interface.

Please make those 3 separate patches.  And yes I think you need the 
first patch as well.  Some code will be optimized away at compile time 
if one of the configs is not selected.

> Please pardon my git ignorance, but I couldn't find any guidelines
> forcing me to use it here.

You're not forced to use Git.  However I'd prefer if you could post 
those patches separately, one per message, with some explanation blurb 
for each patch and a SOB tag.  See Documentation/SubmittingPatches 
for all the details (apply what makes sense).

> During my excursions with the new hardware, it was pointed out that the
> Sheeva u-boot 3.4.19 does not properly initialize the SoC SATA ports
> disallowing further usage; indifferent to the above patches. The "net"
> http://plugcomputer.org/plugforum/index.php?topic=927.0 told me to use
> u-boot 3.4.19 intended for the openrd hardware, and it worked.

That would be good if someone made the necessary patch to add the proper 
initialization to the kernel eventually.


Nicolas
