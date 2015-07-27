From: anurup.m@huawei.com (Anurup M)
Date: Mon, 27 Jul 2015 11:54:38 +0530
Subject: kexec crash kernel boot failure on arm64
In-Reply-To: <20150727051835.GF31919@dhcppc13.redhat.com>
References: <D2393EB95A9993478029A6FE6A290A9F81D90EF8@szxeml510-mbx.china.huawei.com>
 <20150724092934.GA23074@leverpostej>
 <20150727051835.GF31919@dhcppc13.redhat.com>
Message-ID: <55B5CEA6.4050000@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/27/2015 10:48 AM, Pratyush Anand wrote:
> On 24/07/2015:10:29:34 AM, Mark Rutland wrote:
>> On Fri, Jul 24, 2015 at 03:07:24AM +0100, Anurup m wrote:
>>> Hi All,
>>>
>>> There is a problem observed with crash kernel boot in kdump on arm64.
>>
>> With which kernel? Mainline doesn't have kexec or kdump support for
>> arm64.
>>
>>> On arm64 hardware board, when I enable the purgatory segment, the crash kernel doesnot boot.
>>> When checked with trace32, it is observed that the control comes to purgatory_start routine, 
>>> but the instructions are seen as UNDEF and the boot hangs. But when I took the memory dump, the
>>> contents were seen as proper(matching with the purgatory_start code).
>>>
>>> I did some experiments to analyze this issue. Tried changing the Load order of kexec segments and
>>> observed results as below
> 
> As Mark asked, its important to know, which kernel and which
> kexec-tools you are using. I guess, you would be using either Geoff's
> [1] master branch or Akashi's [2] kdump/v0.12 branch for kexec-tools.
> Can you try to increase your crashkernel(=xM) size and use mem=
> parameter appropriately for the primary kernel commandline and see if
> it improves.
> 

Thanks you for the reply. I shall try and let you know.

> ~Pratyush
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git
> [2] https://git.linaro.org/people/takahiro.akashi/kexec-tools.git
> 
> 
> 
> .
> 
