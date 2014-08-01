From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 01 Aug 2014 23:03:52 +0200
Subject: [PATCH v5 07/10] ARM: dts: Clean up exynos5250-arndale
In-Reply-To: <1406868897-26874-8-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-8-git-send-email-afaerber@suse.de>
Message-ID: <53DC00B8.3050008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just wanted to report one issue unrelated to your changes I spotted
while reviewing this patch. See below.

On 01.08.2014 06:54, Andreas F?rber wrote:
> Use the new style of referencing inherited nodes, use symbolic names,
> tidy indentation and reorder includes.
> 
> Goal is the alignment of all exynos5250 based device trees for comparison.

[snip]

> -	fimd: fimd at 14400000 {
> -		status = "okay";
> -		display-timings {
> -			native-mode = <&timing0>;
> -			timing0: timing at 0 {
> -				/* 2560x1600 DP panel */
> -				clock-frequency = <50000>;

This apparently makes little sense as I doubt anybody would be willing
to run a DP panel with refresh rate of 0,012 Hz...

Anyway, your patch just moves it, so this is just an unrelated report.

Best regards,
Tomasz
