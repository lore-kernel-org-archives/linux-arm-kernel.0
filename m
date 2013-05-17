From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 17 May 2013 22:51:04 +0200
Subject: [PATCH 4/6] pinctrl: samsung: Add support for SoC-specific
 suspend/resume callbacks
In-Reply-To: <CAD=FV=Xy2Poti6Wz594DpN1ZbB3FQJ1Dkt+PND1Z0fqf2pJvaw@mail.gmail.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-5-git-send-email-t.figa@samsung.com>
 <CAD=FV=Xy2Poti6Wz594DpN1ZbB3FQJ1Dkt+PND1Z0fqf2pJvaw@mail.gmail.com>
Message-ID: <31112981.QqbfMZZPSN@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 of May 2013 12:24:29 Doug Anderson wrote:
> Tomasz,
> 
> On Fri, May 17, 2013 at 9:24 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > +       if (ctrl->resume)
> > +               ctrl->resume(drvdata);
> > +
> 
> Having this resume at the beginning of the function seems right for
> restoring eint settings like you do in patch #6.
> 
> ...but if you need to try to handle the old s3c64xx and s5p64x0
> concept of "restored" to actually take GPIOs out of powerdown mode
> then you'll also need a callback at the end.
> 
> Does it make sense to add a second callback at the end of this function?

Right. I haven't thought of this. It might make sense to add .resumed() 
callback as well to handle this.

I guess it could be added as a part of patches for S3C64xx-specific 
pinctrl suspend/resume, that I will post some day.

> ...since it's unclear how we'll handle s3c64xx/s5p64x0 (or even if I'm
> misunderstanding and they're already handled somehow), I don't see any
> problems with this patch, so...
> 
> 
> On exynos5250-snow (pinmux backported to 3.8):
> 
> Tested-by: Doug Anderson <dianders@chromium.org>
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>

Thanks.

Best regards,
Tomasz
