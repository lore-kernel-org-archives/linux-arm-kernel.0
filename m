From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Mon, 10 Nov 2014 15:25:40 +0000
Subject: dtb size limit? was Re: Tiny dts change breaks boot on n900
In-Reply-To: <20141110125806.GA16650@amd>
References: <20141110123118.GA31134@amd> <20141110125806.GA16650@amd>
Message-ID: <5460D8F4.9000507@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.11.2014 um 12:58 schrieb Pavel Machek:
> If I replace the blo[ck] below with
> 
>  a = <1>;
>  b = <2>;
>  c = <3>;
>  d = <4>;
> 
> Resulting kernel boots. Replacing it with
> 
>  a-really-long-attribute-name-hopefully-this-breaks-stuff = <1>;
>  b = <2>;
>  c = <3>;
>  d = <4>;
> 
> Breaks the boot. I'm using dtb append option. Any ideas? Nonbooting
> dtb is 68910 bytes.

Did you verify that your initrd, if any, does not overlap the end of the
kernel when loading it from the bootloader?

Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
