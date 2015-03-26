From: ceh@ti.com (Carlos Hernandez)
Date: Thu, 26 Mar 2015 14:13:47 -0400
Subject: [PATCH 04/13] thermal: Fix not emulating critical temperatures
In-Reply-To: <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <55144C5B.7070208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 11:53 AM, Sascha Hauer wrote:
> - The code should only accept an emulated temperature when the emulated
>    temperature is lower than the critical temperature. Instead the code

Why?
Emulating temperatures higher than critical temperature is useful for 
testing. For instance it allows one to validate that critical action 
(i.e. shutdown) is triggered.
