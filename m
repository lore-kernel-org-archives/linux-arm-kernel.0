From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 13 Jul 2011 09:10:12 +0100
Subject: [PATCH 2/3] mach-ux500: export System-on-Chip information via
	sysfs
In-Reply-To: <201107121847.46144.arnd@arndb.de>
References: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
	<1310476090-9807-2-git-send-email-lee.jones@linaro.org>
	<201107121847.46144.arnd@arndb.de>
Message-ID: <4E1D52E4.1040907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/11 17:47, Arnd Bergmann wrote:
> On Tuesday 12 July 2011, Lee Jones wrote:
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Just like last time:
> 
>    NAK
> 
> You still have all the SoC devices as top-level platform devices.
> Make them children of the SoC device you create here, and we can
> apply this patch.

Okay, obviously I'm missing something. I am trying to adhere to your
advice, but there must be some communication break-down somewhere down
the line. Let me attempt to explain what's going on in my head.

You keep asking for the SoC devices to be children of the parent SoC
device and as far as I'm concerned they are. Devices appear like this in
sysfs:

/sys/devices/soc/1   /* 1st SoC */
/sys/devices/soc/2   /* 2nd SoC */
/sys/devices/soc/3   /* 3rd SoC */

etc ...

Surely the parent which you speak of is "soc" and each SoC is
represented by "1|2|3|..."? Under each directory with a digit naming
convention appears that SoC's attributes, namely: "family", "machine",
"process", "revision" and "soc_id".

If this is incorrect, would you be kind enough to tell me why its
incorrect and how you would like it changed/fixed please?

Kind regards,
Lee
