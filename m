From: joe@perches.com (Joe Perches)
Date: Thu, 22 Sep 2011 11:58:49 -0700
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110922184614.25419.84606.stgit@ponder>
References: <20110922184614.25419.84606.stgit@ponder>
Message-ID: <1316717930.21302.11.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-22 at 12:51 -0600, Grant Likely wrote:
> Allow drivers to report at probe time that they cannot get all the resources
> required by the device, and should be retried at a later time.
[]
> I would appreciate
> any feedback.

trivia:

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
[]
> +static void driver_deferred_probe_add(struct device *dev)
> +{
> +	mutex_lock(&deferred_probe_mutex);
> +	if (list_empty(&dev->deferred_probe)) {
> +		dev_dbg(dev, "Added to deferred list\n");

These messages might be more intelligible as
"Added to deferred probe list\n"

> +void driver_deferred_probe_del(struct device *dev)
> +{
> +	mutex_lock(&deferred_probe_mutex);
> +	if (!list_empty(&dev->deferred_probe)) {
> +		dev_dbg(dev, "Removed from deferred list\n");

"Removed from deferred probe list\n"
