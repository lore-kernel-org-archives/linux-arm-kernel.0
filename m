From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 10:58:32 +0200
Subject: [PATCH v2 1/2] video: imxfb: Fix unbalanced regulators
In-Reply-To: <53AA8D8C.2040705@eukrea.com>
References: <1403528839-31901-1-git-send-email-denis@eukrea.com>
 <20140625060848.GE15686@pengutronix.de> <53AA8D8C.2040705@eukrea.com>
Message-ID: <53AA8F38.80703@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2014 10:51 AM, Denis Carikli wrote:
> On 06/25/2014 08:08 AM, Sascha Hauer wrote:
>> It's a shame that the LCD controller doesn't do the reference counting.
[...]
> So I don't see any ways to handle it correctly in the LCD.
Unless if the LCD core, instead of doing reference counting, does the 
check by itself, by using get_power().
But I doubt that it would be a good solution (I fear that it would have 
race conditions).

Denis.
