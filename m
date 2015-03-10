From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Mar 2015 09:52:32 +0000
Subject: [PATCH v2] drivers/base: cacheinfo: validate device node for
 all the caches
In-Reply-To: <1424709159-13152-1-git-send-email-sudeep.holla@arm.com>
References: <1424095816-4414-1-git-send-email-sudeep.holla@arm.com>
 <1424709159-13152-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <54FEBEE0.2030703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 23/02/15 16:32, Sudeep Holla wrote:
> On architectures that depend on DT for obtaining cache hierarcy, we need
> to validate the device node for all the cache indices, failing to do so
> might result in wrong information being exposed to the userspace.
>
> This is quite possible on initial/incomplete versions of the device
> trees. In such cases, it's better to bail out if all the required device
> nodes are not present.
>
> This patch adds checks for the validation of device node for all the
> caches and doesn't initialise the cacheinfo if there's any error.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/base/cacheinfo.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> v1->v2:
>   - Updated log information as suggested by Mark
>   - Added Mark's ACK
>
> Hi Greg,
>
> Can you please pick this fix for the next rc ?
>
> Without this there's possibility that erroneous information is exposed
> to userspace on architecture depending on DT especially if DT lacks
> cache hierarchy information.
>

There are many arm64 DT without cache hierarchy which exposes wrong
cacheinfo to the user space. It would be good to get this included
as bug fix for 4.0

Regards,
Sudeep
