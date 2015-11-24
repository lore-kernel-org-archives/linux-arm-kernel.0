From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 24 Nov 2015 09:07:30 +0100
Subject: [PATCH] modpost: don't add a trailing wildcard for OF module
 aliases
In-Reply-To: <1447943308-27689-1-git-send-email-javier@osg.samsung.com>
References: <1447943308-27689-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1448352450.19513.53.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-11-19 at 11:28 -0300, Javier Martinez Canillas wrote:
> ?scripts/mod/file2alias.c | 3 +--
> ?1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 5b96206e9aab..65eaab8b7798 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -125,7 +125,7 @@ do
> {????????????????????????????????????????????????????????????\
> ?????????????????sprintf(str + strlen(str), "*");????????????????\
> ?} while(0)
> ?
> -/* Always end in a wildcard, for future extension */
> +/* End in a wildcard, for future extension */
> ?static inline void add_wildcard(char *str)
> ?{
> ?	int len = strlen(str);
> @@ -704,7 +704,6 @@ static int do_of_entry (const char *filename,
> void *symval, char *alias)
> ?		if (isspace (*tmp))
> ?			*tmp = '_';
> ?
> -	add_wildcard(alias);
> ?	return 1;
> ?}
> ?ADD_TO_DEVTABLE("of", of_device_id, do_of_entry);

Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

-- 
Sjoerd Simons
Collabora Ltd.
