From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 21 Nov 2016 09:23:39 +0000
Subject: [PATCH] mfd: twl-core: export twl_get_regmap
In-Reply-To: <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
 <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
Message-ID: <20161121092339.GA32509@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 20 Nov 2016, Nicolae Rosia wrote:

> On Fri, Nov 18, 2016 at 8:55 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Sat, 12 Nov 2016, Nicolae Rosia wrote:
> >
> >> We want to get rid of global twl_i2c_{write/read}.
> >> As a first step, allow clients to get the regmap and write directly
> >
> > What's stopping you from passing it through device data?
> >
> Could you elaborate a bit?
> The regmaps are stored in struct twl_client [0], stored in struct
> twl_private [1], both structs are defined in the source file, not in
> header.
> I could however just fix the problem by reworking the struct, exposing
> it and use mfd_add_device as real mfd drivers do.

Woah!  Thanks for prompting me to read this driver.  It's a bit of a
mess isn't it?  I think it would be best to convert it to use the MFD
API, yes.

It's common place to pass shared resources such as 'regmap' though
device data.  You can find many examples of *__set_drvdata throughout
the kernel.

> [0] http://lxr.free-electrons.com/source/drivers/mfd/twl-core.c#L152
> [1] http://lxr.free-electrons.com/source/drivers/mfd/twl-core.c#L163

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
