From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 13 Apr 2011 21:12:05 +0530
Subject: [PATCH 6/6] da8xx: enable the use of the ICPFUNC in i2c-davinci
In-Reply-To: <BANLkTi=j=Dp015ZsU44DH3p1s_XdxvAX8Q@mail.gmail.com>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
	<f1ff3f2888725a1e03541e0be5c0880f0591aea2.1302031487.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F@dbde02.ent.ti.com>
	<BANLkTi=j=Dp015ZsU44DH3p1s_XdxvAX8Q@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C8B3CBD@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 20:52:05, Ben Gardiner wrote:

> >> --- a/arch/arm/mach-davinci/devices-da8xx.c
> >> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> >> @@ -324,6 +324,12 @@ int __init da8xx_register_i2c(int instance,
> >> ? ? ? else
> >> ? ? ? ? ? ? ? return -EINVAL;
> >>
> >> + ? ? /*
> >> + ? ? ?* Both the DA850 and DA830 have an I2C controller which has the
> >> + ? ? ?* ICPFUNC et. al. registers
> >> + ? ? ?*/
> >> + ? ? pdata->has_pfunc = 1;
> >
> > The I2C driver implements a default platform data
> > so it should actually be legal for a DA8x board to
> > pass NULL platform data. In that case this line
> > will crash.
> 
> Good catch, thanks.
> 
> > [...] You should either check for pdata to
> > be NULL or just let each board choose whether it
> > needs recovery (I think the better option).
> 
> I understand "check for pdata to be NULL."  If you think it is the
> better option I'd be happy to implement it but I don't understand how
> to implement "let each board choose whether it needs recovery."

This is done by just setting has_pfunc = 1 in the
davinci_i2c_platform_data defined in the board file.

Thanks,
Sekhar
