From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 May 2014 10:01:26 +0100
Subject: [PATCH] arm: put_user: fix possible data corruption in put_user
In-Reply-To: <1399270438-26181-1-git-send-email-a.ryabinin@samsung.com>
References: <1399270438-26181-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20140505090126.GD3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 10:13:58AM +0400, Andrey Ryabinin wrote:
> According to arm procedure call standart r2 register is call-cloberred.
> So after the result of x expression was put into r2 any following
> function call in p may overwrite r2. To fix this, the result of p
> expression must be saved to the temporary variable before the
> assigment x expression to __r2.

This and the patch make no sense.  You talk about r2, but you're doing
nothing with r2 in the patch.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
