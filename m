From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 20 Nov 2012 08:52:03 +0800
Subject: [PATCH 2/2] ARM: mmp: support pinctrl single in brownstone
In-Reply-To: <50AAA7B1.7060404@wwwdotorg.org>
References: <1353049345-6954-1-git-send-email-haojian.zhuang@gmail.com>
 <1353049345-6954-2-git-send-email-haojian.zhuang@gmail.com>
 <50AAA7B1.7060404@wwwdotorg.org>
Message-ID: <CAN1soZyTad0QVt-oKM24XiHYruyFx5MTiu2+ytGL5RNv-Pqonw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 5:42 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/16/2012 12:02 AM, Haojian Zhuang wrote:
>> Support pinctrl-single driver in brownstone platform with DT.
>
>> diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
>
>>       chosen {
>> -             bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
>> +             bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on earlyprintk";
>
> That seems unrelated.
>
But it's helpful on debug. Should I remove this? I prefer that I could
keep this.

Since I want to watch the whole log before console is enabled.
