From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 23:45:52 +0000
Subject: [PATCH 0/4] Improve CLKSRC_OF matching
In-Reply-To: <51143A87.4040205@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
 <201302072244.51588.arnd@arndb.de> <51143A87.4040205@gmail.com>
Message-ID: <201302072345.52195.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Rob Herring wrote:
> How so? I don't see a warning as there is no type checking on the init
> function since of_device_id.data is just a void *. It would be good to
> have type checking here if you know a way, but I don't.

Ah, that's right. So it silently builds find even though the
prototypes don't match, and given the C calling conventions
it even ends up working correctly, it just feels wrong.

	Arnd
