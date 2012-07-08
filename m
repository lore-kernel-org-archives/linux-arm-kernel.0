From: alainsergenagni@yahoo.com (Alain-Serge Nagni)
Date: Sat, 7 Jul 2012 19:01:47 -0700 (PDT)
Subject: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
In-Reply-To: <201206290009.38518.marex@denx.de>
Message-ID: <1341712907.57646.YahooMailClassic@web124905.mail.ne1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

?1) Thanks for the advice, I will remember to not top post :-)



?2) I spent lot of time testing your new additions to the mxs SPI driver and it works fine. Great job.



Regards,

Alain-Serge


--- On Thu, 6/28/12, Marek Vasut <marex@denx.de> wrote:

From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
To: linux-arm-kernel at lists.infradead.org
Cc: "Alain-Serge Nagni" <alainsergenagni@yahoo.com>, "Fabio Estevam" <festevam@gmail.com>, "Shawn Guo" <shawn.guo@linaro.org>
Date: Thursday, June 28, 2012, 6:09 PM

Dear Alain-Serge Nagni,

> Hi Fabio and Marek,
>? So I did rebuild the Kernel and UBoot to support device tree.? I did
> reboot the system and this time I?m not having any kernel panic. Which is
> a good signJ. After investigation I notice that the? SSP2 node status is
> marked ?disabled? (in the file imx28.dtsi).? So there is no way based on
> the patch that was publish to have the imx-spi driver loaded in the kernel
> at boot time. 
> Mareck,
>? I guess that? you have a piece of code that you forgot to publish? If not
> how can I have your SPI drive to run? 
>? Right now I guess that the next step would be to define the SPI node in
> the im28-evk.dts file.? I will open a thread to see if anybody as a
> solution for that. What is your take on that?
>? 
> Thanks guys,
> Alain-Serge? ? ? ???

[...]

Fabio already answered your question. Lemme teach you a few more rules:
1) Do not top post in the email conversation ;-)
2) About DT. You're supposed to include imx28.dtsi in your imx28-yourboard.dts 
file. Then everything that's already defined in the imx28.dtsi will be present 
in your imx28-yourboard.dts . But the key thing is, if you define something 
again, it will override the stuff already defined in the imx28.dtsi file. But 
you don't have to redefine everything, just redefine what you need changed.

Best regards,
Marek Vasut
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120707/f1a8f008/attachment-0001.html>
