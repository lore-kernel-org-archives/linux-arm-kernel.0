From: bill_carson@126.com (rocky)
Date: Thu, 3 Jun 2010 13:55:42 +0800 (CST)
Subject: Query about arch/arm/boot/compressed/Makefile.debug
In-Reply-To: <AANLkTinEA_7sFG9WqzETirCY76XIIeicKe3Cw9eQvYwx@mail.gmail.com>
References: <AANLkTinEA_7sFG9WqzETirCY76XIIeicKe3Cw9eQvYwx@mail.gmail.com>
	<198ace.57aa.128fc51e27e.Coremail.bill_carson@126.com>
Message-ID: <13ff02f.5b3c.128fc611d48.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Eric

>Conduct?a?strict?memory?checking?and?check?the?cache?enabling?code,?normally
>that's?where?the?problem?is.?The?decompressor?itself,?should?be?less?problematic
>since?it's?working?elsewhere?on?most?other?platforms.

All ARM1176 based SoC share the same cache enable/disable API which defined in arch/arm/boot/compressed/head.S, ARM1176 falls into ARMv7 .

Actually, our DDR run at 800MHz, I'm trying to tune it a little bit lower at 533MHz to see what happened.

thanks for your kind tips.

rocky










?2010-06-03?13:47:00?"Eric?Miao"?<eric.y.miao@gmail.com>????>On?Thu,?Jun?3,?2010?at?1:39?PM,?rocky?<bill_carson@126.com>?wrote:>>?Hi,?all>>?I'm?porting?Linux?to?a?ARM1176?based?SOC,?sometimes?after?running?make?zImage,>>?I?got?CRC?error?when?uncompressing?the?kernel?all?the?time.>>Conduct?a?strict?memory?checking?and?check?the?cache?enabling?code,?normally>that's?where?the?problem?is.?The?decompressor?itself,?should?be?less?problematic>since?it's?working?elsewhere?on?most?other?platforms.>>>>>?no?idea?why?this?should?happened,?i?want?to?use?misc.c?with?STANDALONE_DEBUG?mode,>>?so?how?should?i?use?this?debug?mode?>>>>>>?thanks>>?BR>>?rocky>>>>>>>>?_______________________________________________>>?linux-arm-kernel?mailing?list>>?linux-arm-kernel at lists.infradead.org>>?http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>
