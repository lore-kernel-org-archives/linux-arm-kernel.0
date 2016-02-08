From: jbaron@akamai.com (Jason Baron)
Date: Mon, 8 Feb 2016 14:09:13 -0500
Subject: [PATCH] locking/static_keys: avoid nested functions
In-Reply-To: <1454942223-2781480-1-git-send-email-arnd@arndb.de>
References: <1454942223-2781480-1-git-send-email-arnd@arndb.de>
Message-ID: <56B8E7D9.1080301@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2016 09:36 AM, Arnd Bergmann wrote:
> clang does not support nested functions inside of an array definition:
> 
> lib/test_static_keys.c:105:16: error: function definition is not allowed here
>                         .test_key       = test_key_func(&old_true_key, static_key_true),
> lib/test_static_keys.c:50:20: note: expanded from macro 'test_key_func'
>         ({bool func(void) { return branch(key); } func; })
> 
> That code appears to have been a little too clever, so this
> simplifies it a bit by defining functions outside of the array.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/test_static_keys.c | 62 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
> 

Works for me.

Acked-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason
