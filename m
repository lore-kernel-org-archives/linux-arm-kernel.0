From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 13:22:57 -0600
Subject: [PATCH v5 0/5] efuse driver for Tegra
In-Reply-To: <20140528061645.252c2fbc.akpm@linux-foundation.org>
References: <1401281677-32110-1-git-send-email-pdeschrijver@nvidia.com>
 <20140528061645.252c2fbc.akpm@linux-foundation.org>
Message-ID: <53878911.9090508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 07:16 AM, Andrew Morton wrote:
> On Wed, 28 May 2014 15:54:32 +0300 Peter De Schrijver <pdeschrijver@nvidia.com> wrote:
> 
>> This driver allows userspace to read the raw efuse data.
> 
> The patchset uses an inexplicable mixture of "fuse" and "efuse".
> Given that the kernel already has a "fuse", it would be nice if
> this code could use "efuse" everywhere.

I didn't check every instance, but a mix of those two terms seems
reasonable. "fuse" is the type of HW object; it's a generic HW term that
exists outside the scope of this patch. While the conflict with Linux's
filesystem is unfortunate, it's a name collision that I think we'll
simply have to live with; it's not created by this patch. "efuse" is the
name of the Tegra module that hosts Tegra's fuses.
