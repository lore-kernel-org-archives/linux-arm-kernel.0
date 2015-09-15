From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 15 Sep 2015 12:24:52 +0100
Subject: [PATCH 2/3] devicetree: bindings: use input-event-codes.h for
 evdev codes
In-Reply-To: <1442064372-3030-3-git-send-email-hdegoede@redhat.com>
References: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
 <1442064372-3030-3-git-send-email-hdegoede@redhat.com>
Message-ID: <1442316292.3549.386.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-09-12 at 15:26 +0200, Hans de Goede wrote:
> Add a symlink to uapi/linux/input-event-codes.h, and include that instead
> of (re)defining all the evdev type and code values in
> dt-bindings/input/input.h. This way we do not need to keep all the
> event codes synced manually.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  include/dt-bindings/input/input-event-codes.h |   1 +
>  include/dt-bindings/input/input.h             | 510 +-------------------
> ------
>  2 files changed, 2 insertions(+), 509 deletions(-)
>  create mode 120000 include/dt-bindings/input/input-event-codes.h
> 
> diff --git a/include/dt-bindings/input/input-event-codes.h b/include/dt
> -bindings/input/input-event-codes.h
> new file mode 120000
> index 0000000..693bbcd
> --- /dev/null
> +++ b/include/dt-bindings/input/input-event-codes.h
> @@ -0,0 +1 @@
> +../../uapi/linux/input-event-codes.h
> \ No newline at end of file

Hrm, I think this is going to cause trouble for the split DT repository at
https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/

Since ../../ == include in both trees I think I can make it work by
including include/uapi/linux in the conversion, either wholesale (easiest)
or partially (potentially cleaner).

Any opinions on that?

In principal I ought to regenerate the tree from scratch such that
include/uapi/linux was "always" there and has history but I think we can
live with it just appearing at some point in time wen the conversion script
was updated?

AIUI these values are required to only be used with properties whose names
are of the form "linux,*", otherwise there would be strong complaints about
include Linux uapi stuff into a generic device-tree binding.

Ian.
