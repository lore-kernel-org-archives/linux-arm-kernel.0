From: joe@perches.com (Joe Perches)
Date: Mon, 26 Mar 2018 23:52:04 -0700
Subject: [PATCH script] hwmon: Use octal not symbolic permissions
In-Reply-To: <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
References: <1522096136.12357.21.camel@perches.com>
 <9b112651-d0cf-5f3b-b643-3328028a95cd@roeck-us.net>
Message-ID: <1522133524.12357.56.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-03-26 at 23:33 -0700, Guenter Roeck wrote:
> On 03/26/2018 01:28 PM, Joe Perches wrote:
> > drivers/hwmon is the most frequent user of symbolic permissions
> > like S_IRUGO in the kernel tree.
[]
> I have something similar using coccinelle,

Please post the script.
I expect it doesn't work quite the same as checkpatch.

> which has the added benefit
> of also adjusting multi-line alignments.

That's a benefit, but it's makes it difficult to review.
I also have the same patch rewrap alignment post this
automated patch, done with emacs formatting.

This patch is somewhat simpler to review which is why
it's not sent along with this script.

> But then I am hesitant to pull
> it in because I don't really see the point. A more intelligent approach
> would be to convert hwmon drivers to the latest API, and/or to introduce
> more intelligent macros such as SENSOR_DEVICE_ATTR_{RO,RW,WO}.

Another approach would be to separate the const bits
from the non-const bits to reduce data.

> But that
> would require active work as well as reviewers, and especially the latter
> is extremely difficult if not impossible to find for the hwmon subsystem.

[]

> Since the hwmon subsystem has been labeled as both "obsolete" and "obscure",
> that is maybe not entirely surprising, and I think we are good as we are.

Maybe true.

> I am happy to accept patches updating permissions as other changes are made
> to a file, but I don't see a pressing need to change all files just to make
> statistics happy (and backports more difficult).

Not sure backports are a real issue.

If it were a real issue, the updated permissions are noise
and shouldn't be accepted for the other changes.
