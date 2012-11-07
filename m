From: viresh.kumar@linaro.org (viresh kumar)
Date: Wed, 7 Nov 2012 10:41:51 +0530
Subject: [PATCH 2/5] gpiolib-of: staticize the pin range calls
In-Reply-To: <1352215003-30268-1-git-send-email-linus.walleij@stericsson.com>
References: <1352215003-30268-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOh2x==WYpq_hZa9bZhDNhD_ptE3hw3hBBugtyRu4AN0qetyTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2012 20:46, Linus Walleij <linus.walleij@stericsson.com> wrote:
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c

 #ifdef CONFIG_PINCTRL
-void of_gpiochip_add_pin_range(struct gpio_chip *chip)
+static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 {
        struct device_node *np = chip->of_node;
        struct gpio_pin_range *pin_range;
@@ -254,7 +254,7 @@ void of_gpiochip_add_pin_range(struct gpio_chip *chip)
        } while (index++);
 }

-void of_gpiochip_remove_pin_range(struct gpio_chip *chip)
+static void of_gpiochip_remove_pin_range(struct gpio_chip *chip)
 {
        struct gpio_pin_range *pin_range, *tmp;

@@ -265,8 +265,8 @@ void of_gpiochip_remove_pin_range(struct gpio_chip *chip)
        }
 }
 #else
-void of_gpiochip_add_pin_range(struct gpio_chip *chip) {}
-void of_gpiochip_remove_pin_range(struct gpio_chip *chip) {}
+static void of_gpiochip_add_pin_range(struct gpio_chip *chip) {}
+static void of_gpiochip_remove_pin_range(struct gpio_chip *chip) {}

Maybe static inline??

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
