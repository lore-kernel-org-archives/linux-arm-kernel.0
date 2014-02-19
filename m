From: robherring2@gmail.com (Rob Herring)
Date: Wed, 19 Feb 2014 15:42:11 -0600
Subject: [PATCH RFC v1 2/3] of: Add definition of maximum length of a
 property name
In-Reply-To: <1392829124-25705-3-git-send-email-s.nawrocki@samsung.com>
References: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
 <1392829124-25705-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <CAL_Jsq+0pmLHC2Xo=i3kvQMo+uukraK1nRyPZReKtwE_GEaGFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 10:58 AM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Maximum length of a property name is defined by ePAPR (2.2.4.1) as
> 31 characters. Add a corresponding definition, including the trailing
> null space.

Does dtc enforce this? It would be good to add if not.

> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  include/linux/of.h |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 70c64ba..7f71221 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -30,6 +30,9 @@
>  typedef u32 phandle;
>  typedef u32 ihandle;
>
> +/* Maximum length of name of a property, including terminating null */
> +#define OF_PROP_NAME_MAXLEN    32
> +
>  struct property {
>         char    *name;
>         int     length;
> --
> 1.7.9.5
>
