From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 2 Dec 2016 13:13:54 +0530
Subject: [PATCH v3] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <76e7853b-8235-173a-7214-c450487751c6@lechnology.com>
References: <1480612342-23614-1-git-send-email-abailon@baylibre.com>
 <76e7853b-8235-173a-7214-c450487751c6@lechnology.com>
Message-ID: <c3f07191-d542-ca5e-21f2-87fd0ea06990@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 December 2016 11:17 PM, David Lechner wrote:
> 
>> +        clk_put(usb20_clk);
> 
> The global usb20_clk is no longer valid after this. Should we set it to
> NULL here?

No need of this. Also, NULL is valid clock handle.

Thanks,
Sekhar
