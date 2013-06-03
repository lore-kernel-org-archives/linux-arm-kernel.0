From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 03 Jun 2013 21:29:14 +0900
Subject: mvebu: 3.10-rc1 and fixes branch doesn't boot on OpenBlocks
 AX3
In-Reply-To: <51AC6380.9050607@free-electrons.com>
References: <51AC5E14.1050207@hitachi.com>
 <51AC6380.9050607@free-electrons.com>
Message-ID: <51AC8C1A.2060809@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/06/03 18:36), Gregory CLEMENT wrote:
> On 06/03/2013 11:12 AM, Masami Hiramatsu wrote:
>> Hi,
> Hi
> 
>>
>> I've tried 3.10-rc1 and
>> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git fixes branch on my
>> OpenBlocks AX3-4 and failed to boot both kernel
>> as below.
> 
> Since 3.10 the memory description for the Armada XP is 64 bits, to
> allow to use more than 4GB of RAM with LPAE.
> Unfortunately the ATAGS are 32 bits only.
> If you use more than 4GB your only possibility is to disable
> the ATAG support and only rely on the information written in
> the dts: disable CONFIG_ARM_ATAG_DTB_COMPAT.
> 
> If you don't have more than 4GB of RAM then you can also apply this
> patch: https://patchwork.kernel.org/patch/2566771/
> It allows to use the ATAG and to keep the CONFIG_ARM_ATAG_DTB_COMPAT
> option.

Thanks for the information!
That patch solves my issue :)

Best regards,


-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
