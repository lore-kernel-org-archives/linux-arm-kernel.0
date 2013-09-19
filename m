From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 Sep 2013 12:10:34 +0200
Subject: [PATCH v3 RFT 1/2] init/do_mounts.c: ignore final \n in
 name_to_dev_t
In-Reply-To: <1379546942-22344-2-git-send-email-sebastian.capella@linaro.org>
References: <1379546942-22344-1-git-send-email-sebastian.capella@linaro.org>
 <1379546942-22344-2-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20130919101034.GD19346@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-09-18 16:29:01, Sebastian Capella wrote:
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
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
