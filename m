From: james.morse@arm.com (James Morse)
Date: Tue, 1 May 2018 18:46:04 +0100
Subject: [PATCH v9 02/11] kexec_file: make
 kexec_image_post_load_cleanup_default() global
In-Reply-To: <20180425062629.29404-3-takahiro.akashi@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-3-takahiro.akashi@linaro.org>
Message-ID: <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 25/04/18 07:26, AKASHI Takahiro wrote:
> Change this function from static to global so that arm64 can implement
> its own arch_kimage_file_post_load_cleanup() later using
> kexec_image_post_load_cleanup_default().

Do we need to call kexec_image_post_load_cleanup_default()? All it does is call
the image-type fops->cleanup(), which you don't implement in this series.

Is this just-in-case someone adds cleanup() later and is surprised only the
arch-level helper is called?


Thanks,

James
