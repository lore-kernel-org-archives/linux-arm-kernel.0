From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 21 Jan 2016 20:15:25 +0100
Subject: 4.5-rc0: n900 battery charging reverts to 100mA, indicator turns
 back on
In-Reply-To: <20160121184234.GA17679@amd>
References: <20160121184234.GA17679@amd>
Message-ID: <20160121191525.GA26215@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 21, 2016 at 07:42:34PM +0100, Pavel Machek wrote:
> In 4.4, n900 battery charging works. If indicator is turned off, it
> stays off, and if I select 1.8A charge, it sticks. (There may be
> problems after system suspend and resume. But normal operation seems
> to be pretty reliable).
> 
> In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery charging
> works for few hours. But then indicator (yellow light on 3color LED)
> turns back on, and if I ask for 1.8A charge, it goes back to .1A,
> discharging battery.
> 
> Any ideas?

Maybe a side-effect of isp1704 driver actually doing what was
intended, which is is 88025632515a ("power: isp1704_charger: Fix
isp1704_write()").

P.S.: No need to Cc me two times and when you update your
script/contacts, please use sre at kernel.org :)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/d0e0b6d7/attachment-0001.sig>
