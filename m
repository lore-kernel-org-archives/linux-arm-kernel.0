From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Dec 2012 23:10:01 +0900
Subject: [PATCH 02/12] regulator: gpio-regulator: Only read GPIO
 [dis|en]able pin if not always-on
In-Reply-To: <1355129761-8088-3-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20121210141000.GC6103@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 08:55:51AM +0000, Lee Jones wrote:
> If a regulator is specified as always-on, then it can't have an
> enable/disable pin, as it can't be turned off.

Sometimes always on gets set for regulators which do have a physical
control wired up - the control might exist for use in suspend mode for
example.  Is the ability to specify an enable pin causing a practical
problem for systems?  If it is we should fix that.
