From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 31 Aug 2016 15:33:47 +0200
Subject: [PATCH 1/9] ARM: dts: exynos: Add macros for GPIO configuration
In-Reply-To: <bf55b24c-b1ee-78be-d56d-8fdda4f2fdc9@samsung.com>
References: <1472645613-5362-1-git-send-email-k.kozlowski@samsung.com>
 <6113443.1q3Xq4YM82@wuerfel>
 <bf55b24c-b1ee-78be-d56d-8fdda4f2fdc9@samsung.com>
Message-ID: <5709554.y3Mq6my3Uz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 31, 2016 3:07:00 PM CEST Krzysztof Kozlowski wrote:
> 
> Ok, sounds reasonable. I want to convert also older platforms S3C (drive
> strengths and pull up/down differ) and arm64 SoC: Exynos7. For the
> latter the problem is there is no common place for sharing DTS, except
> the headers. However this does not really belong to headers. I guess
> some level of duplication might be still exist.

We have stuff in the headers that belongs way less there, so I wouldn't
mind, but having a separate set of definitions for arm64 also isn't
a problem at all.
 
> > I think overall, a better solution would have been to define the
> > constants globally (shared with non-exynos) to start with,
> > and have the driver translate generic numbers into vendor
> > specific ones. Obviously it's too late for that now.
> 
> We could extend driver by adding new bindings accepting generic numbers
> (and still backward compatible) but this looks like an overkill.

Agreed, that would only make things more confusing, not less.

	Arnd
