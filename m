From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2015 10:40:55 +0100
Subject: [PATCH V4 2/3] arm64: support initrd outside kernel linear map
In-Reply-To: <FC378C09-F140-4A62-9FFA-09293E65E866@gmail.com>
References: <1439830867-14935-1-git-send-email-msalter@redhat.com>
 <1439830867-14935-3-git-send-email-msalter@redhat.com>
 <20150908113113.GA20562@leverpostej>
 <20151006171140.GE26433@leverpostej>
 <1444151812.10788.14.camel@redhat.com>
 <20151008084953.GA20114@cbox>
 <FC378C09-F140-4A62-9FFA-09293E65E866@gmail.com>
Message-ID: <20151008094055.GC32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 05:18:14PM +0800, yalin wang wrote:
> is it also possible to implement it on ARM platforms?
> ARM64 platform don?t have HIGH_MEM zone .
> but ARM platform have .
> i remember boot loader must put init rd  into low memory region,
> so if some boot loader put init rd into HIGH men zone
> we can also relocate it to low men region ?
> then boot loader don?t need care about this ,
> and since vmalloc= boot option will change HIGH mem region size,
> if we can relocate init rd , boot loader don?t need care about init rd load address,
> when change vmalloc= boot options .

I'd be more inclined to say yes if the kernel wasn't buggering around
passing virtual addresses (initrd_start) of the initrd image around,
but instead used a physical address.  initrd_start must be a lowmem
address.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
