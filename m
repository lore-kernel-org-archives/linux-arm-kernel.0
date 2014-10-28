From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 17:10:24 +0100
Subject: [PATCH v7 4/7] ARM: dts: Enable Broadcom Cygnus SoC
In-Reply-To: <1414011474-11821-5-git-send-email-sbranden@broadcom.com>
References: <1414011474-11821-5-git-send-email-sbranden@broadcom.com>
Message-ID: <12464460.6zhqY1bzdG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 October 2014 13:57:51 Scott Branden wrote:
> +
> +       aliases {
> +               serial0 = &uart3;
> +               serial1 = &uart0;
> +       };
> +
> +       chosen {
> +               bootargs = "console=ttyS0,115200 earlyprintk debug";
> +       };
> 

Please move the 'aliases' and 'chosen' node into the .dts files, these
are board specific, not SoC specific.

For chosen, please remove earlyprintk and debug, which don't normally
make sense unless you are debugging, and which will break in a multiplatform
kernel.

Please also add an "stdout-path = &uart3" property in chosen so that
earlycon can work. Note that earlycon is currently broken on arm32,
but we'll get there.

	Arnd
