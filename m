From: robherring2@gmail.com (Rob Herring)
Date: Wed, 16 Apr 2014 10:34:36 -0500
Subject: [PATCH 4/5] exynos4-is: Remove requirement for "simple-bus"
 compatible
In-Reply-To: <1397583272-28295-5-git-send-email-s.nawrocki@samsung.com>
References: <1397583272-28295-1-git-send-email-s.nawrocki@samsung.com>
 <1397583272-28295-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAL_Jsq+VRGpVZwFs1QwCz6YY8WmPUO7ZJtWQ3kVY8p1jWe0LGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 12:34 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This patch makes the driver instantiating its child devices itself,
> rather than relying on an OS to instantiate devices as children
> of "simple-bus". This removes an incorrect usage of "simple-bus"
> compatible.

Good, but why can't you use of_platform_populate with the root being
the "samsung,fimc" node? The code to instantiate the devices belongs
in the core OF code.

Rob
