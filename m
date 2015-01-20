From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 10:29:19 +0000
Subject: [PATCH v3 2/3] mfd: lubbock_io: add lubbock_io board
In-Reply-To: <87ppaah9k5.fsf@free.fr>
References: <1421406010-14851-1-git-send-email-robert.jarzmik@free.fr>
 <1421406010-14851-2-git-send-email-robert.jarzmik@free.fr>
 <20150119091705.GG21886@x1> <87ppaah9k5.fsf@free.fr>
Message-ID: <20150120102919.GP5767@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jan 2015, Robert Jarzmik wrote:
> Lee Jones <lee.jones@linaro.org> writes:
> > On Fri, 16 Jan 2015, Robert Jarzmik wrote:

[...]

> >> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >
> > platform_get_irq()?
> No. I need the flags.

Where are they used?

[...]

> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "Couldn't request main irq : ret = %d\n",
> >> +			ret);
> >
> > I'm not keen on this type of formatting.  Besides the system will
> > print out the returned error on failure.
> Well, it will print -EINVAL or -ENODEV. When I'll receive an request on the
> driver with -ENODEV, how will I know it will come from this request_irq() or
> another part of the code ... Well I can remove it if you want, but I think it's
> an error.

I'm not asking you to remove the entire message, just the junk at the
end.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
