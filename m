From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 27 Feb 2010 17:17:12 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <952338.61061.qm@web51008.mail.re2.yahoo.com>
References: <952338.61061.qm@web51008.mail.re2.yahoo.com>
Message-ID: <1267287432.2723.90.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sab, 2010-02-27 at 07:38 -0800, Fabio Estevam wrote:
> Hi Alberto,
> 
> --- On Sat, 2/27/10, Alberto Panizzo <maramaopercheseimorto@gmail.com> wrote:
> 
> > From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> > Subject: Re: [PATCH] mx31pdk: Add NAND support
> > To: "Fabio Estevam" <fabioestevam@yahoo.com>
> > Cc: linux-arm-kernel at lists.infradead.org, s.hauer at pengutronix.de
> > Date: Saturday, February 27, 2010, 12:25 PM
> > Dear Fabio,
> > 
> > On ven, 2010-02-26 at 17:34 -0800, Fabio Estevam wrote:
> > > Hi Sascha,
> > > 
> > ...
> > > 
> > > Do you think this patch is OK?
> > > 
> > > Regards,
> > > 
> > > Fabio Estevam
> > 
> > I do not know if Sascha own an i.MX31 PDK board and I 
> > do not know how Sascha could say if your patch is correct
> > or not
> > until WE (i.MX31 PDK owners) are in disagree on this code.
> > So _please_, be _kind_ and continue the debugging of this
> > code.
> 
> Ok, I just did what all the others i.MX boards did.
> 
> > (Why your bootloader correctly read the BBT and the driver
> > not?)
> > 
> > Another thing: I am a new graduated developer, I do this
> > work
> > keeping in mind my future and until now I am not paid to do
> > this.
> > What I gain is in experience and resume with my name in the
> > 
> > kernel Git log.
> 
> This is great. Please continue with this work.
> 
> > If you are thinking to push my entire work with your name
> > only
> > because I sent you my own mx31_3ds.c out of this mailing
> > list
> > you are in _wrong_.
> 
> This is not my intention. The mx31_3ds.c you sent me helped me to solve a different issue related to the LCD driver. The NAND patch I submitted in this list is not the same you had in your code as I did not pass flash_bbt.
> So your comment that I am pushing your entire work is not fair.
> 
> > Review of my work are welcome, BUT please, do not overcome
> > me
> > thinking that Sascha can merely arbitrate between us. 
> > 
> 
> Again, Alberto, I would love to work together with you and make i.MX support better.
> 
> Regards,
> 
> Fabio Estevam
> 

Ok Fabio, nevermind.. I trust the pure intentions of the kernel community
and yours. For one moment I've lost the compass (we say this in Italy, I don't
know if it is valid too here) and I apologize for unfairness (I've spent months
on this board! urk!)

Returning on the subject, I was not the first owner of the i.MX pdk board in my
possess, and since the freescale NAND driver uses a private OOB schema, others
could have soiled my nand chip overwriting the Bad block bits in the OOB.

The things are two: 
1- I have to clean my NAND chip. -> the bad block scanning could 
   get rid of true Bad blocks.
2- Why the mxc_nand driver do not read your bbt as the 
   bootloader do?
   What version of redboot are you using?
   I am Very curious on this disagreement..!

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
