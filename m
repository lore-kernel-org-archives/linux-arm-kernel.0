From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 12 Jul 2011 09:36:06 +0200
Subject: [PATCH v3] MAX1111: Fix Race condition causing NULL pointer
	exception
In-Reply-To: <1310421038-14823-1-git-send-email-morpheus.ibis@gmail.com>
References: <1310421038-14823-1-git-send-email-morpheus.ibis@gmail.com>
Message-ID: <20110712093606.5db834cb@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jul 2011 23:50:38 +0200, Pavel Herrmann wrote:
> spi_sync call uses its spi_message parameter to keep completion information,
> using a drvdata structure is not thread-safe, potentially causing one thread
> having pointers to memory on or above other threads stack. use mutex to
> prevent multiple access

Honestly, I have no idea what "causing one thread having pointers to
memory on or above other threads stack" means (nor why this would be
bad.)

Patch applied nevertheless, as it fixes an actual bug which should be
fixed ASAP. Thanks for your contribution.

-- 
Jean Delvare
