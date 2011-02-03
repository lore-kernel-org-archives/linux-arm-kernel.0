From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 3 Feb 2011 12:45:21 +0000
Subject: [PATCH 1/5] ARM: etm: Don't require clock control
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Message-ID: <20110203124521.GK9810@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 06:54:19PM -0800, Arve Hj??nnev??g wrote:
> If clk_get fail, assume the etb does not need a separate clock.
> 
> Signed-off-by: Arve Hj??nnev??g <arve@android.com>

Would it not be cleaner for the affected platforms to ensure that
clk_get() does the right thing here, for example by returning a dummy
clock?  Otherwise we'll just silently carry on if we can't get a clock
we were supposed to which doesn't seem ideal.
