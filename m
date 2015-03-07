From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Mar 2015 15:00:35 +0000
Subject: [PATCH v1 1/6] eeprom: Add a simple EEPROM framework for eeprom
 providers
In-Reply-To: <1425548741-12930-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1425548685-12887-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1425548741-12930-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150307150035.GN28806@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 09:45:41AM +0000, Srinivas Kandagatla wrote:

> +
> +	return eeprom;
> +}
> +EXPORT_SYMBOL(eeprom_register);

This framework uses regmap but regmap is EXPORT_SYMBOL_GPL() and this is
using EXPORT_SYMBOL().

> +int eeprom_unregister(struct eeprom_device *eeprom)
> +{
> +	mutex_lock(&eeprom_mutex);
> +	if (atomic_read(&eeprom->users)) {
> +		mutex_unlock(&eeprom_mutex);

Atomic reads and a mutex - isn't the mutex enough?  Atomics are
generally a recipie for bugs due to the complexity in using them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150307/8a4486a4/attachment.sig>
