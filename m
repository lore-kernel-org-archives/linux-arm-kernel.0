From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jan 2015 10:48:26 +0000
Subject: [PATCH] arm64: kill off the libgcc dependency
In-Reply-To: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
References: <1421231934-31720-1-git-send-email-haokexin@gmail.com>
Message-ID: <20150114104826.GD4050@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 10:38:54AM +0000, Kevin Hao wrote:
> The arm64 doesn't depend on the libgcc to build the vmlinux image.

Yes it does; we make use of __builtin_* for our bitops, for example.
The compiler guys don't guarantee that these will be inlined.

Will
