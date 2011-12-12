From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 12 Dec 2011 13:39:06 -0700
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111212054053.GD9572@S2100-06.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
 <20111212054053.GD9572@S2100-06.ap.freescale.net>
Message-ID: <4EE6666A.9040005@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2011 10:40 PM, Shawn Guo wrote:
>> +	memory {
>> +		reg =<0x10000000 0x40000000>;
>> +	};
>> +
>> +	soc {
>> +		aips-bus at 02100000 { /* AIPS2 */
>> +			enet at 02188000 {
>> +				phy-mode = "rgmii";
>> +				local-mac-address = [01 04 9F 01 1B 61];
> Do we still have no way to figure the mac address from hardware setup
> (fuse or something) on sabrelite board?
>
>
U-boot now has support for blowing the mac fuses.

i.e.
imxotp blow --force 23 0019 ; imxotp blow --force 22 B800e1f5

for a mac of 00:19:b8:00:e1:f5

Most boards already have this done.

Troy
