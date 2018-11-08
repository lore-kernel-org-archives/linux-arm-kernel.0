From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 08 Nov 2018 09:58:59 -0800
Subject: [PATCH 1/4] of/device: Add a way to probe drivers by match data
In-Reply-To: <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
References: <20181106183609.207702-1-sboyd@kernel.org>
 <20181106183609.207702-2-sboyd@kernel.org>
 <efa13e0b-0daf-3bf3-27ba-ed90f15c7dfe@gmail.com>
Message-ID: <154169993998.88331.10494065577891939152@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Matthias Brugger (2018-11-08 00:29:46)
> On 06/11/2018 19:36, Stephen Boyd wrote:
> > +int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
> > +{
> > +     int (*probe_func)(struct platform_device *pdev);
> > +
> > +     probe_func = of_device_get_match_data(&pdev->dev);
> 
> Shouldn't we check if probe_func is not NULL?

Is the oops from the NULL pointer deref insufficient?
