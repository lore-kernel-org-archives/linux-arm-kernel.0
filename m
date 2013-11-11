From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 11 Nov 2013 16:41:33 +0530
Subject: [PATCH RFC 1/4] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <000301ceda84$1d648bf0$582da3d0$%han@samsung.com>
References: <1383205544-32244-1-git-send-email-gautam.vivek@samsung.com>
 <1383205544-32244-2-git-send-email-gautam.vivek@samsung.com>
 <527744B2.4090303@ti.com>
 <030d01ced946$d6e23490$84a69db0$%debski@samsung.com>
 <52779D28.9000905@ti.com>
 <CAFp+6iH7vQ-OtMFL4pyr4tFDRchH4oh1Z0753WNgrHiUzj+kzw@mail.gmail.com>
 <00fe01ceda0a$941957a0$bc4c06e0$%debski@samsung.com>
 <000001ceda17$f41c2030$dc546090$%han@samsung.com>
 <000101ceda1f$04ca6f20$0e5f4d60$%han@samsung.com>
 <CAFp+6iFAZab35F-MOOZHcHpzSEOL=51gWBK2KZbOJS+0731GJQ@mail.gmail.com>
 <000301ceda84$1d648bf0$582da3d0$%han@samsung.com>
Message-ID: <5280BB65.5040305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 06 November 2013 05:37 AM, Jingoo Han wrote:
> On Wednesday, November 06, 2013 2:58 AM, Vivek Gautam wrote:
>> On Tue, Nov 5, 2013 at 5:33 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> 
> [.....]
> 
>>> USB3.0 PHY consists of two blocks such as 3.0 block and 2.0 block.
>>> This USB3.0 PHY can support UTMI+ and PIPE3 interface for 3.0 block
>>> and 2.0 block, respectively.
>>>
>>> Conclusion:
>>>
>>>    1) USB2.0 PHY: USB2.0 HOST, USB2.0 Device
>>>                        Base address: 0x1213 0000
>>>
>>>    2) USB3.0 PHY: USB3.0 DRD (3.0 HOST & 3.0 Device)
>>>                        Base address: 0x1210 0000
>>>                        2.0 block(UTMI+) & 3.0 block(PIPE3)
>>
>> And this is of course the PHY used by DWC3 controller, which works at
>> both High speed as well as Super Speed.
>> Right ?
> 
> Right.
> 
> While 3.0 block(PIPE3) can be used for Super Speed, 2.0 block(UTMI+)
> can be used for High speed.

It should then come under *single IP muliple PHY* category similar to what
Sylwester has done.

Thanks
Kishon
