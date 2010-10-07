From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 7 Oct 2010 19:33:35 +0800
Subject: [PATCH] cpufreq for freescale mx51
In-Reply-To: <20101007080358.GH2457@matterhorn.lan>
References: <1286429788-1955-1-git-send-email-yong.shen@linaro.org>
	<1286429788-1955-2-git-send-email-yong.shen@linaro.org>
	<20101007080358.GH2457@matterhorn.lan>
Message-ID: <AANLkTimP9SHDtktO6jr3MTp2DnKLJOuaEfCFxRBD4kDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  # Object file lists.
> > -obj-y   := cpu.o mm.o clock-mx51.o devices.o
> > +obj-y   := cpu.o mm.o clock-mx51.o devices.o cpu_wp-mx51.o
>
> By hardcoding cpu_wp-mx51 here, you are making the assumption that even if
> cpufreq is turned off, you'll still need the entire WP table to set the
> cpu frequency. Why can't this be handled transparently in the clock code?
> If
> the clock code does the calculations, every board doesn't need to first
> setup
> calls to get_cpu_wp.
>
>
It has history. Not only cpufreq needs this  table, other freescale drivers
also need it, like dvfs and busfreq drivers. So it is better to be there. I
do agree clock should do its calculation by itself.
Agree about the rest.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101007/5e9777fb/attachment-0001.html>
