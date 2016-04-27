From: prime.zeng@hisilicon.com (Zengtao (B))
Date: Wed, 27 Apr 2016 02:13:01 +0000
Subject: [PATCH] arm64: fix /proc/cpuinfo for elf32
In-Reply-To: <571F32F3.7080005@arm.com>
References: <1461555453-60440-1-git-send-email-prime.zeng@huawei.com>
 <20160425091239.GB9614@e104818-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED0A6E6FB7@SZXEMA509-MBX.china.huawei.com>
 <571F32F3.7080005@arm.com>
Message-ID: <678F3D1BB717D949B966B68EAEB446ED0A6E7595@SZXEMA509-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Suzuki K Poulose [mailto:Suzuki.Poulose at arm.com]
> Sent: Tuesday, April 26, 2016 5:21 PM
> To: Zengtao (B); Catalin Marinas
> Cc: will.deacon at arm.com; mark.rutland at arm.com; yang.shi at linaro.org;
> linux-kernel at vger.kernel.org; james.morse at arm.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] arm64: fix /proc/cpuinfo for elf32
> 
> On 26/04/16 03:21, Zengtao (B) wrote:
> >
> > So you mean the 64-bit grep should see the same cpuinfo as its father process
> > which is 32-bit?
> >
> > For 32-bit process running on 64-bit kernel, we have to explicitly call the
> personality
> > syscall to get the right cpuinfo, but how to deal with the old 32-bit binaries?
> 
> Yes, you could use the syscall to switch the personality. Alternately, you could
> run
> "linux32" command to switch the personality to PER_LINUX32 and then
> execute
> 64/32 bit applications.
>

Any plan to place the personality syscall in libc? It is not nessary for each 32-bit process 
to do the personality syscall or linux32 command. 
 
> Suzuki
> 
> 
