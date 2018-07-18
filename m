From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 17 Jul 2018 20:49:54 -0700
Subject: [PATCH v7 01/10] counter: Introduce the Generic Counter interface
In-Reply-To: <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
Message-ID: <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jun 2018 17:07:08 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch introduces the Generic Counter interface for supporting
> counter devices.
> 

+EXPORT_SYMBOL(count_direction_str);
+EXPORT_SYMBOL(count_mode_str);
+EXPORT_SYMBOL(counter_signal_enum_read);
+EXPORT_SYMBOL(counter_signal_enum_write);
+EXPORT_SYMBOL(counter_signal_enum_available_read);
+EXPORT_SYMBOL(counter_count_enum_read);
+EXPORT_SYMBOL(counter_count_enum_write);
+EXPORT_SYMBOL(counter_count_enum_available_read);
+EXPORT_SYMBOL(counter_device_enum_read);
+EXPORT_SYMBOL(counter_device_enum_write);
+EXPORT_SYMBOL(counter_device_enum_available_read);
+EXPORT_SYMBOL(signal_read_value_set);
+EXPORT_SYMBOL(count_read_value_set);
+EXPORT_SYMBOL(count_write_value_get);
+EXPORT_SYMBOL(counter_register);
+EXPORT_SYMBOL(counter_unregister);
+EXPORT_SYMBOL(devm_counter_register);
+EXPORT_SYMBOL(devm_counter_unregister);

The naming is a bit chaotic.  Most of the symbols start with counter_,
which is good.  But a handful do not.

Also, symbols called signal_* make my head spin - Linux already has a
firmly ingrained notion of what a signal is, and this ain't it ;)
Although the kernel tends to use sig_ for signals-as-an-IPC-thing.

Also, many many drivers deal with signals-as-an-electrical-thing - is
it appropriate for this particular driver to take that namespace?
