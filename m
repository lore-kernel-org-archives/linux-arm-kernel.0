From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 3 Oct 2013 14:15:23 -0700
Subject: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
In-Reply-To: <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  3 Oct 2013 14:10:37 -0700 Sebastian Capella <sebastian.capella@linaro.org> wrote:

> Enhance name_to_dev_t to handle trailing newline characters
> on device paths.  Some inputs to name_to_dev_t may come from
> userspace where oftentimes a '\n' is appended to the path.
> Added const to the name buffer in both the function
> declaration and the prototype to reflect input buffer
> handling.
> 
> By handling trailing newlines in name_to_dev_t, userspace
> buffers may be directly passed to name_to_dev_t without
> modification.

We have lib/string.c:strim() - perhaps this patch would be
neater if it were to use it?
