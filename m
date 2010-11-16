From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 16 Nov 2010 22:07:08 +0530
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <4CE2AB73.3050109@mvista.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ABE7@dbde02.ent.ti.com>
	<4CE124AE.4080301@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ACE1@dbde02.ent.ti.com>
	<4CE1560F.6080705@mvista.com>
	<AANLkTimDpYrx_OWg7ABXqRJ5JYzhpVbbyzVMhmFD6Wxi@mail.gmail.com>
	<4CE2AB73.3050109@mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234ADA4BC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 21:34:03, Sergei Shtylyov wrote:

>
> > HI Sergei and Sekhar
>
> > Thanks for check the patch
>
> > What I can do if you agree with this change is to leave da850.c as it
> > is,
>
>     No, please don't.
>
> > and declare
>
> > static short hawk_mcasp_pins[] __initdata = {
> >     DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
> >     DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
> >     DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,
> >     -1
> > };
>
> > on the hawkboard file and call it insted of da850_mcasp_pins.
>
> >     ret = davinci_cfg_reg_list(hawk_mcasp_pins);
> >     if (ret)
> >             pr_warning("%s: mcasp mux setup failed: %d\n", __func__, ret);
>
> > Please tell me if you agree with this change, I think is better
> > because I do not touch any other file besides my board file.
>
>     No, it's not really better. The generic list in da850.c should be more
> complete, regardless... Ideally, you should go thru the DA850 manual and put in
> that list all McASP pins that aren't already there. Then you can use your own
> pin list if that *complete* pin list can't be used on your board.

That will cause a bunch of pin conflicts on the EVM so it will need
its own list too.

Thanks,
Sekhar
