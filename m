From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Jun 2012 00:09:38 +0200
Subject: [PATCH 7/7] ARM: mxs: Add SPI driver for mx233/mx28
In-Reply-To: <1340885853.84699.YahooMailClassic@web124903.mail.ne1.yahoo.com>
References: <1340885853.84699.YahooMailClassic@web124903.mail.ne1.yahoo.com>
Message-ID: <201206290009.38518.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alain-Serge Nagni,

> Hi Fabio and Marek,
>  So I did rebuild the Kernel and UBoot to support device tree.  I did
> reboot the system and this time I?m not having any kernel panic. Which is
> a good signJ. After investigation I notice that the  SSP2 node status is
> marked ?disabled? (in the file imx28.dtsi).  So there is no way based on
> the patch that was publish to have the imx-spi driver loaded in the kernel
> at boot time. 
> Mareck,
>  I guess that  you have a piece of code that you forgot to publish? If not
> how can I have your SPI drive to run? 
>  Right now I guess that the next step would be to define the SPI node in
> the im28-evk.dts file.  I will open a thread to see if anybody as a
> solution for that. What is your take on that?
>  
> Thanks guys,
> Alain-Serge         

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
