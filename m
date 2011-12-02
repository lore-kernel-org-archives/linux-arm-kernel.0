From: khilman@ti.com (Kevin Hilman)
Date: Fri, 02 Dec 2011 13:25:08 -0800
Subject: [RFC PATCH 03/11] arm:omap:am33xx: Add power domain data
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6039FFA@DBDE01.ent.ti.com>
 (Sekhar Nori's message of "Fri, 2 Dec 2011 18:14:48 +0000")
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
 <1321809555-13833-4-git-send-email-hvaibhav@ti.com>
 <878vmxump8.fsf@ti.com>
 <DF0F476B391FA8409C78302C7BA518B6039FFA@DBDE01.ent.ti.com>
Message-ID: <874nxiis3v.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Nori, Sekhar" <nsekhar@ti.com> writes:

> On Thu, Dec 01, 2011 at 06:34:19, Hilman, Kevin wrote:
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > From: Afzal Mohammed <afzal@ti.com>
>> >
>> > This patch adds AM33XX power domain data,
>> > corresponding API's to access PRM module and
>> > PRM register offsets & bit fields.
>> >
>> > Signed-off-by: Rachna Patil <rachna@ti.com>
>> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> 
>> First some general comments:
>> 
>> At first glance, it seems like there could be much more reuse with OMAP4
>> code here.  From what I see, AM33x has only one partition compared to
>> several on OMAP4, but that doesn't mean you couldn't reuse the OMAP4
>> functions and just use a single partition.
>> 
>> IOW, it seems to me that all the pwrdm_ops could be shared with OMAP4.
>> 
>> From what I read (after an admittedly quick glance), the main thing you
>> need is a way to override the PRM offsets due to the fact that some
>> crazy person decided to make each instance different.
>
> If its any consolation, this has been fed back to the chip designers
> and is expected to be corrected for the next AM335x derivative.

Great, Thanks!   

Assuming mainline kernel support is a priority for the other SoCs in
this family, keeping SW compatibility with other existing SoCs in the
OMAP family should be a high priority.  This is especially true when
large portions of the IP are reused from existing SoCs, as is clearly
the case in AM33x.

Kevin
