From: broonie@kernel.org (Mark Brown)
Date: Sat, 19 Sep 2015 08:01:29 -0700
Subject: [PATCH v5 07/23] regulator: core: Remove regulator_list
In-Reply-To: <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442494637-3674-8-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150919150129.GR12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 02:57:01PM +0200, Tomeu Vizoso wrote:
> As we are already registering a device with regulator_class for each
> regulator device, regulator_list is redundant and can be replaced with
> calls to class_find_device() and class_for_each_device().

This appears to leak references to the struct devices returned by
class_find_device() - it takes a reference before it returns so any
device found using class_find_device() needs to be released with
put_device() and I don't see any new put_device() calls in here.

> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None

This is not the case at all, this patch was newly added.  If you want
to include changelogs like this in the patch description try to ensure
that they bear some relationship to reality, if they don't they are
actively harmful as they are likely to mislead or annoy the reader.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150919/0f1c939b/attachment.sig>
