From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 27 Sep 2010 01:13:42 +0100
Subject: [PATCH] ARM: s3c2442: gta02: Fix usage gpio bank j pin definitions
In-Reply-To: <1285352658-20355-1-git-send-email-lars@metafoo.de>
References: <1285352658-20355-1-git-send-email-lars@metafoo.de>
Message-ID: <4C9FE1B6.2060005@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/10 19:24, Lars-Peter Clausen wrote:
> The gta02 header file still uses the old S3C2410_GPJx defines instead of the
> S3C2410_GPJ(x) macro. Since the S3C2410_GPJx defines have already been removed
> this causes a build failure.
> This patches fixes the issue by doing a s,S3C2410_GPJ([\d]+),S3C2410_GPJ(\1),g
> on the file.

Is this currently causing a build error? If so, please add the snippet
of the build log. Otherwise it'll get queued for the next merge.
