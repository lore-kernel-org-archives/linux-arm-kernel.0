From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 14 Oct 2011 10:07:54 +0200
Subject: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
In-Reply-To: <20111013154803.GH21648@n2100.arm.linux.org.uk>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001160937.GF11710@n2100.arm.linux.org.uk>
	<4E8F028C.10102@stericsson.com>
	<20111008091036.GF25689@n2100.arm.linux.org.uk>
	<CACRpkdY=DFW+J_pQetK38mPqic2iBuDWCx5QZTo-NkL1L37Fuw@mail.gmail.com>
	<4E92AB66.1030406@stericsson.com>
	<20111013154803.GH21648@n2100.arm.linux.org.uk>
Message-ID: <4E97EDDA.8090108@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> So if they apply, they are independent AFAICT.
>> 7108/1 and 7109/1, have real dependencies. Otherwise there none.
> 
> Ok, I assume that those depend on the first two patches.
> 
> So, I tried applying 7110/1 .. 7112/1 but the first rejects because it
> doesn't have the non-power-of-2 support patch applied (7107/1).  And
> it seems sensible that 7107/1 depends on 7106/1 (the PIO patch) which
> I believe to be a problem.
> 

I see the problem.

The patches from the patch serie "Clarify code paths for how to modify 
the power register" are independent from this "SDIO serie". Although the 
patches has been based upon the patches from the SDIO serie, which is as 
you say the reason to why they not apply cleanly.

I will upload a second version of the serie "Clarify code paths for how 
to modify the power register" which is NOT based on the "SDIO serie". 
Then when can discuss each serie separately.

> Therefore, I don't think any of these can be applied without the
> initial PIO patch.
> 
> One thing I haven't yet mentioned is about the non-power-of-2 support -
> surely this can only be supported if blksz_datactrl16 is set?  If so,
> shouldn't it key off that?  I don't see how it could otherwise support
> non-power of 2 block sizes with just a log2 of the block size programmed
> into the data control register.
> 

Your observation is correct, but at the same time do we really need to 
have such a dependency check in the code? The hardware setup is handled 
in the variant struct completely, so we believe that should be enough.
