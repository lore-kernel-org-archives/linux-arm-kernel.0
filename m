From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 12 Feb 2013 10:49:29 +0000
Subject: [RFC] i2c: Providing hooks for i2c multimaster bus arbitration.
In-Reply-To: <20130210181710.GB12760@nekote.pengutronix.de>
References: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
 <20130210181710.GB12760@nekote.pengutronix.de>
Message-ID: <511A1E39.5000304@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/13 18:17, Wolfram Sang wrote:
> On Mon, Feb 04, 2013 at 02:33:15PM +0530, Yuvaraj Kumar C D wrote:
>> This RFC patch is w.r.t multimaster bus arbitration which is already
>> being discussing in the mainline.
>> This patch provides hooks for the i2c multimaster bus arbitration
>> and to have the arbitration parameters.
>
> I still haven't understood why the arbitration specified in the I2C
> standard is not enough for you. Or what you would need to make use of
> it.

I am a little concerned as there is no way to actually lock a bus to
stop another master from transmitting. You can get collisions in a
multi-master environment. Drivers need fixing to deal with collisions
and let the sender know the operation has failed.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
