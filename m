From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Dec 2016 09:40:18 -0800
Subject: [PATCH v3] mach-omap2: fixing wrong strcat for Non-NULL
 terminated string
In-Reply-To: <1481170230-2120-1-git-send-email-maninder1.s@samsung.com>
References: <1481170230-2120-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20161227174018.GT4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Maninder Singh <maninder1.s@samsung.com> [161207 20:16]:
> Issue caught with static analysis tool:
> "Dangerous usage of 'name' (strncpy doesn't always 0-terminate it)"
> 
> Use strlcpy _includes_ the NUL terminator, and  strlcat() which ensures 
> that it won't overflow the buffer.

Applying into omap-for-v4.10/fixes thanks.

Tony
